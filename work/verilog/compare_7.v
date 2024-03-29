/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module compare_7 (
    input [15:0] a,
    input [15:0] b,
    input [1:0] alufnIn,
    output reg out
  );
  
  
  
  always @* begin
    
    case (alufnIn)
      2'h1: begin
        if (a == b) begin
          out = 1'h1;
        end else begin
          out = 1'h0;
        end
      end
      2'h2: begin
        if (a < b) begin
          out = 1'h1;
        end else begin
          out = 1'h0;
        end
      end
      2'h3: begin
        if (a <= b) begin
          out = 1'h1;
        end else begin
          out = 1'h0;
        end
      end
      default: begin
        out = 1'h0;
      end
    endcase
  end
endmodule
