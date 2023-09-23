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
end two_bit_adder;

architecture ripple_carry of two_bit_adder is

    signal c : std_logic_vector (1 downto 0);

begin
    lsb : entity work.full_adder(decomposed_arch)
                     port map (
                                carry_in => c(0),
                                i1 => a(0),
                                i0 => b(0),
                                carry_out => c(1),
                                sum => sum(0)
                              );
    msb : entity work.full_adder(decomposed_arch)
                     port map (
                                carry_in => c(1),
                                i1 => a(1),
                                i0 => b(1),
                                carry_out => sum(2),
                                sum => sum(1)
                              );
    c(0) <= '0';

end ripple_carry;