\m5_TLV_version 1d: tl-x.org
\m5
   
   // =================================================
   // Welcome!  New to Makerchip? Try the "Learn" menu.
   // =================================================
   
   //use(m5-1.0)   /// uncomment to use M5 macro library.
\SV
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   
   |calc
      @0
         $reset = *reset ;
      @1
         $val2[31:0] = $rand2[3:0] ;
         $val1[31:0] = >>2$out ;
         $valid = $reset ? '0 : (1+>>1$valid) ;
         $valid_or_reset = $reset || !$valid ;
      ?$valid_or_reset
         @1
            $diff[31:0] = $val2 - $val1;
            $sum[31:0] = $val2 + $val1;
            $prod[31:0] = $val2 * $val1;
            $quot[31:0] = $val2 / $val1;

         @2
            $mem[31:0] = $reset ? '0 : ($op[2:0] == 3'b101) ? $val1 : >>2$mem;
            $out[31:0] = $reset ? '0 :
                        ($op[2:0] == 3'b000) ? $sum :
                        ($op[2:0] == 3'b001) ? $diff :
                        ($op[2:0] == 3'b010) ? $prod :
                        ($op[2:0] == 3'b011) ? $quot :
                        ($op[2:0] == 3'b100) ? >>2$mem :>>2$out;
            
            

\SV
   endmodule

            
