-- VHDL 8 bit processor Project
-- D Flip Flop Test Bench
-- James Hicks November 1 2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity d_ff_tb is
end d_ff_tb;

architecture tb of d_ff_tb is

    signal d, en, rst, clk, q : std_logic := '0';

    constant clk_period : time := 10 ns;

begin

    DUT: entity work.d_ff_en(two_seg_arch)
    port map( d   => d,
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
    data_process : process
    begin

        wait for 50 ns;
        d <= '1';
        wait for 30 ns;
        d <= '0';
        wait for 40 ns;
        d <= '1';
        wait for 10 ns;
        d <= '0';
        for I in 1 to 18 loop
            wait for 10 ns;
            d <= not d;
        end loop;
        wait for 50 ns;
        d <= '1';
        wait for 50 ns;
        d <= '0';
        wait for 20 ns;
        d <= '1';
        wait;
    end process;

    -- enable process
    en_process : process
    begin
        wait for 50 ns;
        en <= '1';
        wait for 160 ns;
        en <= '0';
        wait for 100 ns;
        en <= '1';
        wait;
    end process;

    -- termination process
    termination_process : process
    begin
        wait for 450 ns;
        assert false report "end of test" severity failure;
    end process;

    -- rst process
    rst_process : process
    begin
        rst <= '1';
        wait for 5 ns;
        rst <= '0';
        wait;
    end process;
end tb;