class sco extends uvm_scoreboard;

    `uvm_component_utils(sco)

    uvm_analysis_imp #(seq_item, sco) recv;

    bit [7:0] exp;
    int count = 0;

    function new(string name = "sco", uvm_component parent = null);
        super.new(name, parent);
        recv = new("recv", this);
    endfunction : new

    function void write(seq_item s_req);
   	   count++;

        if (s_req.en) begin
            if (s_req.dir == 0)
                exp = {exp[6:0], s_req.d}; 
            else
                exp = {s_req.d, exp[7:1]}; 
        end
      
        if (s_req.out !== exp)
            `uvm_error(get_type_name(), $sformatf("[Mismatch] exp = %0h, got = %0h", exp, s_req.out))
        else
            `uvm_info(get_type_name(), $sformatf("[Match] exp = %0h, got = %0h", exp, s_req.out), UVM_LOW)

    endfunction

endclass : sco

