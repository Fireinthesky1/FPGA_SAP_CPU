-- One Bit Comparitor --

library ieee;
use ieee.std_logic_1164.all;

entity one_bit_comparitor is
    port ( i0 : in std_logic;
           i1 : in std_logic;
           eq : out std_logic);
end one_bit_comparitor;

architecture sop_arch of one_bit_comparitor is
    signal p0, p1 : std_logic;
begin
    eq <= p0 or p1;
    p1 <= i0 and i1;
    p0 <= (not i0) and (not i1);
end sop_arch;