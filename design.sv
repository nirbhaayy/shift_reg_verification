module shift_reg  #(parameter MSB=8)(   input d,                      
                                        input clk,                    
                                        input en,                    
                                        input dir,                    
                                        input rstn,                   
                                        output reg [MSB-1:0] out
                                   );
  
  always @ (posedge clk) begin
    
      if (!rstn)
         out <= 0;
      else begin
         if (en)
            case (dir)
               0 :  out <= {out[MSB-2:0], d};
               1 :  out <= {d, out[MSB-1:1]};
            endcase
         else
            out <= out;
      end
    $display("[DUT] out :- %b",out);
  end
  
endmodule : shift_reg
