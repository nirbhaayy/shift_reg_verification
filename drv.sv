class drv extends uvm_driver #(seq_item);

    `uvm_component_utils(drv)
    
    virtual shift_reg_intf vif;

    function new(string name = "drv", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual shift_reg_intf)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NO_VIF", {"Failed to get interface for: ", get_type_name(), ".vif"})
        end
    endfunction : build_phase


    virtual task drive();
        vif.d   <= req.d;
        vif.en  <= req.en;
        vif.dir <= req.dir; 
        `uvm_info(get_type_name(), req.convert2string(), UVM_LOW)
    endtask


    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
          @(posedge vif.clk);	
           seq_item_port.get_next_item(req);
           drive();
           seq_item_port.item_done();
           
        end

    endtask : run_phase

endclass : drv
