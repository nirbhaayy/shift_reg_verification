class env extends uvm_env;

    `uvm_component_utils(env)

    agent a;
    sco   s;

    function new(string name = "env", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        a = agent::type_id::create("a", this);
        s = sco::type_id::create("s", this);
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        a.m.send.connect(s.recv);
    endfunction : connect_phase

endclass : env

