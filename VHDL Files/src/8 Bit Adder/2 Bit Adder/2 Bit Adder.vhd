-- VHDL 8 bit processor Project
-- 2 Bit Ripple Carry Adder
-- James Hicks Sept 22 2023

library ieee;
use ieee.std_logic_1164.all;

entity two_bit_adder is
    port (
            a, b : in std_logic_vector (1 downto 0);
            sum : out std_logic_vector (2 downto 0)
         );
end two_bit_ripple_carry_adder;

architecture ripple_carry of two_bit_adder is
    component full_adder
        port(
                carry_in, i1, i0 : in std_logic;
                carry_out, sum : out std_logic
            );
    signal p0;
begin
    lsb : full_adder port map (
                                carry_in => '0';
                                i1 => a(0);
                                i0 => b(0);
                                carry_out => p0;
                                sum => sum(0)
                              );
    msb : full_adder port map (
                                carry_in => p0;
                                i1 => a(1);
                                i0 => a(0);
                                carry_out => sum(2);
                                sum => sum(1)
                              );
end ripple_carry;