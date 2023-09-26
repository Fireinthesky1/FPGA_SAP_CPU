-- Two Bit Comparitor --

library ieee;
use ieee.std_logic_1164.all;

entity two_bit_comparitor is
    port (
            a, b : in std_logic_vector (1 downto 0);
            output : out std_logic
         );
end two_bit_comparitor;

architecture struct_arch of two_bit_comparitor is

    signal p0, p1 : std_logic;

begin

    LSB : entity work.one_bit_comparitor(sop_arch)
        port map (
                    i0 => a(0),
                    i1 => b(0),
                    eq => p0
                 );
    MSB : entity work.one_bit_comparitor(sop_arch)
        port map (
                    i0 => a(1),
                    i1 => b(1),
                    eq => p1
                 );
    output <= p0 and p1;
end struct_arch;