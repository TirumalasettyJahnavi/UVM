module counter();

    initial begin
        $display("Hello from SystemVerilog!");
        #10;
        $display("10 ns completed");
        $finish;
    end

endmodule