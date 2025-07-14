class base_test extends uvm_test;

    `uvm_component_utils(base_test)

    env       env_o;
    base_seq  req;

    function new(string name = "base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        env_o = env::type_id::create("env_o", this);
        req = base_seq::type_id::create("req");
        uvm_config_db#(uvm_active_passive_enum)::set(this, "env_o.a", "is_active", UVM_ACTIVE);

    endfunction : build_phase

    task run_phase(uvm_phase phase);
         super.run_phase(phase);

         phase.raise_objection(this, "Starting test");
         
         req = base_seq::type_id::create("req");
         
         if (env_o.a.seqr == null) begin
           `uvm_fatal("TEST", "Sequencer is NULL. Check agent instantiation.")
         end
         
         req.start(env_o.a.seqr);

         phase.drop_objection(this, "Test complete");    
      	 
         phase.phase_done.set_drain_time(this, 20ns);

    endtask : run_phase

endclass : base_test
