class base_seq extends uvm_sequence #(seq_item);

    `uvm_object_utils(base_seq)

    bit temp[$];       // Queue for storing values of d
    string d_vals = ""; 

    function new(string name = "base_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        seq_item tr;

        repeat (8) begin
            `uvm_do(tr)
            temp.push_back(tr.d);
        end

        d_vals = "Final values of d: ";

        foreach (temp[i])
            d_vals = {d_vals, $sformatf("%0b ", temp[i])};

        `uvm_info(get_type_name(), d_vals, UVM_LOW)

    endtask : body

endclass : base_seq
