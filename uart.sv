// Code your design here


module serial_UART
  (
    input logic clk,
    input logic reset,
    input logic serial_in,
    output logic [7:0] data_out,
    output logic valid
  );
  
  typedef enum logic [2:0]
  {
    IDLE,
    START,
    RECV,
    STOP,
    DONE
  }state_t;
  
  state_t state, next_state;
  
  logic [2:0] bit_cnt;
  logic [7:0] shift_reg;
  
  
  // 1. State register: Update state on clock
  always_ff @(posedge clk or posedge reset) begin
    if (reset)
      state <= IDLE;
    else
      state <= next_state;
  end
  
  always_comb
    begin
      case(state)
        IDLE: next_state = (serial_in==0) ? START:IDLE;
        START: next_state = RECV;
        RECV: next_state = (bit_cnt == 3'd7) ? STOP : RECV;
        STOP:   next_state = (serial_in == 1) ? DONE : IDLE; // Check stop bit
        DONE:   next_state = IDLE;
        default: next_state = IDLE;
      endcase
    end
  
  always_ff @(posedge clk or negedge reset)
    begin
      if(reset)
        begin
          bit_cnt = 0;
          shift_reg = 0;
          valid = 0;
        end
      else
        begin
          case(state)
            START : begin
              bit_cnt<=0;
              shift_reg <=8'd0;
              valid <=0;
            end
            RECV: begin
              shift_reg <= {serial_in, shift_reg[7:1]};
              bit_cnt <= bit_cnt +1;
            end
            STOP: begin
              valid <=0;
            end
            DONE: begin
              valid <=1;
            end
            default : valid<=0;
          endcase
        end
    end
  
  assign data_out = shift_reg;
  
endmodule