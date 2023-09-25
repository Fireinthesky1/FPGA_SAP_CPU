-- VHDL 8 bit processor Project
-- Eight Bit Bitwise AND
-- James Hicks Sept 25 2023

library ieee;
use ieee.std_logic_1164.all;

entity eight_bit_bitwise_and is
    port (
            a, b : in std_logic_vector (7 downto 0);
            output : out std_logic_vector (7 downto 0)
         );
end eight_bit_bitwise_and;

architecture my_arch of eight_bit_bitwise_and is

begin

    output(7) <= a(7) and b(7);
    output(6) <= a(6) and b(6);
    output(5) <= a(5) and b(5);
    output(4) <= a(4) and b(4);
    output(3) <= a(3) and b(3);
    output(2) <= a(2) and b(2);
    output(1) <= a(1) and b(1);
    output(0) <= a(0) and b(0);

end my_arch;