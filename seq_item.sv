class seq_item extends uvm_sequence_item;

    `uvm_object_utils(seq_item)
    
    function new(string name = "seq_item");
        super.new(name);
    endfunction : new
    
    rand bit         d;
    rand bit        en;
    rand bit       dir; 
         bit [7:0] out;

    function string convert2string();
        return $sformatf("| d   : %0b | en  : %0b | dir : %0b | out : %0h |", d, en, dir, out);
    endfunction : convert2string

   constraint en_always_one { en == 1 ;}
   constraint tr_one        { dir == 0; }

endclass : seq_item
