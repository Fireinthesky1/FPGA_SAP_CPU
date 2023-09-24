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

architecture carry_lookahead of two_bit_adder is

    signal g, p : std_logic_vector (1 downto 0);
    signal c : std_logic_vector (3 downto 0);

begin

 -- propogate and generate signals
    p(0) <= b(0) or a(0);
    g(0) <= b(0) and a(0);
    p(1) <= b(1) or a(1);
    g(1) <= b(1) and a(1);

    c(0) <= carry_in and p(0);
    c(1) <= g(0) or c(0);
    c(2) <= carry_in and p(1) and p(0);
    c(3) <= p(1) and g(0);

    sum(0) <= carry_in xor b(0) xor a(0);
    sum(1) <= a(1) xor b(1) xor c(1);

    carry_out <= c(3) or c(2) or g(1);

end carry_lookahead;