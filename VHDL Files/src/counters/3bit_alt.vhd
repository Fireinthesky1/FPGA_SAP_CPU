--TODO::FILE JUST FOR TESTING DELETE
--TODO::TESTINGIF DEBOUNCE IS THE ISSUE

library ieee;
use ieee.std_logic_1164.all;

entity threebitcounter_alt is
  port ( clk : in  std_logic;
         rst : in  std_logic;
         cnt : out std_logic_vector(2 downto 0)
         );
end threebitcounter_alt;

architecture my_arch of threebitcounter_alt is

signal q0_int, q1_int, q2_int : std_logic;

begin

  q2_int <= q0_int and q1_int;

  ff_1 : entity work.t_ff(two_seg_arch)
    port map ( t   => '1',
               en  => '1',
               rst => rst,
               clk => clk,
               q   => q0_int
             );

  ff_2 : entity work.t_ff(two_seg_arch)
    port map ( t   => q0_int,
               en  => '1',
               rst => rst,
               clk => clk,
               q   => q1_int);

  ff_3 : entity work.t_ff(two_seg_arch)
    port map (t    => q2_int,
              en   => '1',
              rst  => rst,
              clk  => clk,
              q    => cnt(2)
              );

  cnt(1) <= q1_int;
  cnt(0) <= q0_int;

end my_arch;
