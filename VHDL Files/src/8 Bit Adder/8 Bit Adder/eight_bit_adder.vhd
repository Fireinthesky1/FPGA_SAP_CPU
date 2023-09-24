-- VHDL 8 bit processor Project
-- Eight Bit Adder
-- James Hicks Sept 23 2023

-- Needs testing

library ieee;
use ieee.std_logic_1164.all;

entity eight_bit_adder is
    port (
            carry_in : in std_logic;
            a, b : in std_logic_vector (7 downto 0);
            carry_out : out std_logic;
            sum : out std_logic_vector (7 downto 0)
         );
end eight_bit_adder;

architecture ripple_carry of eight_bit_adder is

signal carry_through : std_logic;

begin
    first_four_bits : entity work.four_bit_adder(ripple_carry)
        port map (
                    carry_in => carry_in,
                    a => a (3 downto 0),
                    b => b (3 downto 0),
                    carry_out => carry_through,
                    sum => sum (3 downto 0)
                 );
    last_four_bits : entity work.four_bit_adder(ripple_carry)
        port map (
                    carry_in => carry_through,
                    a => a (7 downto 4),
                    b => b (7 downto 4),
                    carry_out => carry_out,
                    sum => sum (7 downto 4)
                 );

end ripple_carry;