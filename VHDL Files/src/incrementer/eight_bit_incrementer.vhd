-- VHDL 8 bit processor Project
-- Eight Bit Incrementer
-- James Hicks Sept 24 2023

-- Do we need the cout wire here if we are ignoring the output of 8BAdder

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eight_bit_incrementer is
    port (
            input : in std_logic_vector (7 downto 0);
            output : out std_logic_vector (7 downto 0)
         );
end eight_bit_incrementer;

architecture my_arch of eight_bit_incrementer is

    signal cin_wire : std_logic;
    signal cout_wire : std_logic;

begin
    adder : entity work.eight_bit_adder(carry_lookahead_ripple_carry)
        port map (
                    carry_in => cin_wire,
                    a => input (7 downto 0),
                    b => "00000001",
                    carry_out => cout_wire,
                    sum => output (7 downto 0)
                 );
        cin_wire <= '0';
end my_arch;