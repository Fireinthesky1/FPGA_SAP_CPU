-- VHDL 8 bit processor Project
-- Eight Bit Bitwise OR
-- James Hicks Oct 1 2023

library ieee;
use ieee.std_logic_1164.all;

entity eight_bit_bitwise_or is
    port (
            a, b : in std_logic_vector (7 downto 0);
            output : out std_logic_vector (7 downto 0)
         );
end eight_bit_bitwise_or;

architecture my_arch of eight_bit_bitwise_or is

begin

    output (7) <= a(7) or b(7);
    output (6) <= a(6) or b(6);
    output (5) <= a(5) or b(5);
    output (4) <= a(4) or b(4);
    output (3) <= a(3) or b(3);
    output (2) <= a(2) or b(2);
    output (1) <= a(1) or b(1);
    output (0) <= a(0) or b(0);

end my_arch;