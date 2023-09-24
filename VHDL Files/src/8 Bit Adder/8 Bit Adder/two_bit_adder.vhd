-- VHDL 8 bit processor Project
-- 2 Bit Ripple Carry Adder
-- James Hicks Sept 22 2023

-- edited sept 23 to allow for carry in and carry out

library ieee;
use ieee.std_logic_1164.all;

entity two_bit_adder is
    port (
            carry_in : in std_logic;
            a, b : in std_logic_vector (1 downto 0);
            carry_out : out std_logic;
            sum : out std_logic_vector (1 downto 0)
         );
end two_bit_adder;

architecture ripple_carry of two_bit_adder is

    signal carry_through : std_logic;

begin
    lsb : entity work.full_adder(decomposed_arch)
        port map (
                    carry_in => carry_in,
                    i1 => a(0),
                    i0 => b(0),
                    carry_out => carry_through,
                    sum => sum(0)
                );
    msb : entity work.full_adder(decomposed_arch)
        port map (
                    carry_in => carry_through,
                    i1 => a(1),
                    i0 => b(1),
                    carry_out => carry_out,
                    sum => sum(1)
                 );

end ripple_carry;