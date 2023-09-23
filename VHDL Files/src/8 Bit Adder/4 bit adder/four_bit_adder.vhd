-- VHDL 8 bit processor Project
-- Four Bit Adder
-- James Hicks Sept 23 2023

library ieee;
use ieee.std_logic_1164.all;

entity four_bit_adder is
    port (
            carry_in : in std_logic;
            a, b : in std_logic_vector (3 downto 0);
            carry_out : out std_logic
            sum : out std_logic_vector (3 downto 0);
         );
end four_bit_adder;

architecture ripple_carry of four_bit_adder is

signal carry_through : std_logic;

begin
    first_two_bits : entity work.two_bit_adder(ripple_carry)
        port map (
                    carry_in => carry_in,
                    a => a (1 downto 0),
                    b => b (1 downto 0),
                    carry_out => carry_through,
                    sum => sum (1 downto 0)
                 );
    last_two_bits : entity work.two_bit_adder(ripple_carry)
        port map (
                    carry_in => carry_through,
                    a => a (3 downto 2),
                    b => b (3 downto 2),
                    carry_out => carry_out,
                    sum => sum (3 downto 2)
                 );

end ripple_carry;