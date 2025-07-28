// Code your testbench here
// or browse Examples


module tb_serial_UART;
  
  
  logic clk;
  logic reset;
  logic serial_in;
  
  logic[7:0] data_out;
  logic valid;
  
  serial_UART dut
  (
    .clk(clk),
    .reset(reset),
    .serial_in(serial_in),
    .data_out(data_out),
    .valid(valid)
  );
  
  always #5 clk = ~clk;
  
  task send_serial_byte(input [7:0] data);
    begin
      serial_in = 0;
      @(posedge clk);
      
      for(int i=0;i<8;i++)
        begin
          serial_in = data[i];
          @(posedge clk);
        end
      
      serial_in=1;
      @(posedge clk);
    end
  endtask
  
   initial begin
    $display("Starting UART serial receiver test...");
     clk=0;
    reset = 1;
    serial_in = 1; // Idle line high
    @(posedge clk);
    reset = 0;

    // Send a byte: 8'b10101011 => LSB first: 11010101
    send_serial_byte(8'b10101011);

    // Wait for data_valid
    repeat (5) @(posedge clk);

    if (valid && data_out == 8'b10101011) begin
      $display("PASS: Received data = %b", data_out);
    end else begin
      $display("FAIL: Expected 10101011, got %b (valid = %b)", data_out, valid);
    end

    $finish;
  end
  
endmodule