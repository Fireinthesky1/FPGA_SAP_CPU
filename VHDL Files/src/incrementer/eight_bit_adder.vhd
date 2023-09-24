-- VHDL 8 bit processor Project
-- Eight Bit Adder
-- James Hicks Sept 23 2023

-- Needs verification for tests (maybe)

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

architecture carry_lookahead_ripple_carry of eight_bit_adder is

    signal carry_through : std_logic_vector (2 downto 0);

begin
    bits_1_0 : entity work.two_bit_adder(carry_lookahead)
        port map (
                    carry_in => carry_in,
                    a => a (1 downto 0),
                    b => b (1 downto 0),
                    carry_out => carry_through (0),
                    sum => sum (1 downto 0)
                 );
    bits_3_2 : entity work.two_bit_adder(carry_lookahead)
        port map (
                    carry_in => carry_through (0),
                    a => a (3 downto 2),
                    b => b (3 downto 2),
                    carry_out => carry_through (1),
                    sum => sum (3 downto 2)
                 );
    bits_5_4 : entity work.two_bit_adder(carry_lookahead)
        port map (
                    carry_in => carry_through (1),
                    a => a (5 downto 4),
                    b => b (5 downto 4),
                    carry_out => carry_through (2),
                    sum => sum (5 downto 4)
                 );
    bits_7_6 : entity work.two_bit_adder(carry_lookahead)
        port map (
                    carry_in => carry_through (2),
                    a => a (7 downto 6),
                    b => b (7 downto 6),
                    carry_out => carry_out,
                    sum => sum (7 downto 6)
                 );

end carry_lookahead_ripple_carry;