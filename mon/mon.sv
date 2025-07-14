class mon extends uvm_monitor;

    `uvm_component_utils(mon)

  	seq_item tr;
    virtual shift_reg_intf vif;
    uvm_analysis_port #(seq_item) send;

    function new(string name = "mon", uvm_component parent = null);
        super.new(name, parent);
        send = new("send", this);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual shift_reg_intf)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NO_VIF", {"Failed to get interface for: ", get_type_name(), ".vif"})
        end
        tr = seq_item::type_id::create("tr");
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        
        forever begin  
            @(posedge vif.clk);

            tr.d    = vif.d;
            tr.en   = vif.en;
            tr.dir  = vif.dir;
            #1;
            tr.out  = vif.out;
            send.write(tr);
			
           `uvm_info(get_type_name(), tr.convert2string(), UVM_LOW)
        end
    endtask : run_phase

endclass : mon
