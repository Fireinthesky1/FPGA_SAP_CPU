-- VHDL 8 bit processor Project
-- D Flip Flop Test Bench
-- James Hicks November 1 2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t_ff_tb is
end t_ff_tb;

architecture tb of t_ff_tb is

    signal t, en, rst, clk, q : std_logic := '0';

    constant clk_period : time := 10 ns;

begin

    DUT: entity work.t_ff_en(two_seg_arch)
    port map( t   => t,
              en  => en,
              rst => rst,
              clk => clk,
              q   => q
            );

    -- clock process
    clk_process : process
    begin
        loop
            wait for clk_period / 2;
            clk <= not clk;
        end loop;
    end process;

    -- data  process
    t_process : process
    begin
        wait for 20 ns;
        t <= '1';
        wait for 30 ns;
        t <= '0';
        wait for 40 ns;
        t <= '1';
        for I in 1 to 9 loop
            wait for 10 ns;
            t <= not t;
        end loop;
        wait for 20 ns;
        t <= '1';
        wait;
    end process;

    -- enable process
    en_process : process
    begin
        wait for 20 ns;
        en <= '1';
        wait for 210 ns;
        en <= '0';
        wait for 30 ns;
    end process;

    -- termination process
    termination_process : process
    begin
        wait for 260 ns;
        assert false report "end of test" severity failure;
    end process;

    -- rst process
    rst_process : process
    begin
        rst <= '1';
        wait for clk_period / 2;
        rst <= '0';
        wait;
    end process;
end tb;