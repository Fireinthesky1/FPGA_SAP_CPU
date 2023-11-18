library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--TODO: TEST THIS

entity stopwatch is
  port ( clk   : in  std_logic;
         en    : in  std_logic;
         clr   : in  std_logic;
         fast  : in  std_logic;
         sseg  : out std_logic_vector(7 downto 0);
         anode : out std_logic_vector(7 downto 0));
end stopwatch;

architecture my_arch of stopwatch is

  signal tick_0, tick_1, tick_2, tick_3         : std_logic;
  signal                   en_2,   en_3,   en_4 : std_logic;
  signal          cnt_1,  cnt_2,  cnt_3,  cnt_4 : std_logic_vector(3 downto 0);
  signal         sseg_1, sseg_2, sseg_3, sseg_4 : std_logic_vector(7 downto 0);
  signal                                 blnk_4 : std_logic_vector(7 downto 0);

begin

--COUNTER STAGES

  ctrstg_0 : entity work.ctrstg(my_arch)
    port map ( clr  => clr,
               en   => en,
               clk  => clk,
               tick => tick_0,
               cnt  => open );

  ctrstg_1 : entity work.ctrstg(my_arch)
    port map ( clr  => clr,
               en   => tick_0,
               clk  => clk,
               tick => tick_1
               cnt  => cnt_1 );

  en_2 <= tick_0 and tick_1;

  ctrstg_2 : entity work.ctrstg(my_arch)
    port map ( clr  => clr,
               en   => en_2,
               clk  => clk,
               tick => tick_2,
               cnt  => cnt_2 );

  en_3 <= en_2 and tick_2;

  ctrstg_3 : entity work.ctrstg(my_arch)
    port map ( clr  => clr,
               en   => en_3,
               clk  => clk,
               tick => tick_3,
               cnt  => cnt_3 );

  en_4 <= en_3 and tick_3;

  ctrstg_4 : entity work.ctrstg(my_arch)
    port map ( clr  => clr,
               en   => en_4,
               clk  => clk,
               tick => open
               cnt  => cnt_4 );

--HEX TO SSEGS

  hex_to_sseg_1 : entity work.hex_to_sseg(Behavioral)
    port map ( hex  => cnt_1,
               dp   => '1',                              --TODO: DON"T LIGHT UP?
               sseg => sseg_1 );

  hex_to_sseg_2 : entity work.hex_to_sseg(Behavioral)
    port map ( hex  => cnt_2,
               dp   => '0',                                    --TODO: LIGHT UP?
               sseg => sseg_2 );

  hex_to_sseg_3 : entity work.hex_to_sseg(Behavioral)
    port map ( hex  => cnt_3,
               dp   => '1',                              --TODO: DON't LIGHT UP?
               sseg => sseg_3);

  hex_to_sseg_4 : entity work.hex_to_sseg(Behavioral)
    port map ( hex  => cnt_4,
               dp   => '1',                              --TODO: DON'T LIGHT UP?
               sseg => sseg_4);

--ZERO BLANKER

  zero_blanker_4 : entity work.zero_blanker(my_arch)
    port map ( input  => sseg_4,
               output => blnk_4);

--DISPLAY MUX

  disp_mux : entity work.disp_mux(Behavioral)
    port map ( in0   => "11111111";
               in1   => "11111111";
               in2   => "11111111";
               in3   => "11111111";
               in4   => blnk_4;
               in5   => sseg_3;
               in6   => sseg_2;
               in7   => sseg_1;
               rst   => '0';
               clk   => clk;
               sseg  => sseg
               anode => anode );

end my_arch;
