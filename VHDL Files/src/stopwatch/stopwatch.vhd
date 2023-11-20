library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
  signal tick_slow, tick_fast                   : std_logic;

begin

--COUNTER STAGES
--NOTE: 100ms tick generator
--TODO: Update the max and width for 100 ms timer
  ctrstg_0 : entity work.ctrstg(my_arch)
    generic map( max   => 1250000, -- <- 1/8th of 10 million
                 width => 15 )
    port map ( clr  => clr,
               en   => en,
               clk  => clk,
               tick => tick_fast,
               cnt  => open );

--TEST CODE---------------------------------------------------------------------

--NOTE: IF FAST = '0' THIS STAGE'S OUTPUT WILL BE USED
--NOTE: THIS IS A CLOCK DIVIDER BY 8
  ctrstd_slow : entity work.ctrstg(my_arch)
    generic map ( max   => 7,
                  width => 4 )
    port map ( clr  => clr,
               en   => tick_fast,
               clk  => clk,
               tick => tick_slow,
               cnt  => open );

tick_0 <= tick_fast when (fast = '1') else (tick_slow and tick_fast);

--TEST CODE---------------------------------------------------------------------



--NOTE: .1 second counter
  ctrstg_1 : entity work.ctrstg(my_arch)
    generic map ( max   => 9,
                  width => 4 )
    port map ( clr  => clr,
               en   => tick_0,
               clk  => clk,
               tick => tick_1,
               cnt  => cnt_1 );

  en_2 <= tick_0 and tick_1;

--NOTE: 1 second counter
  ctrstg_2 : entity work.ctrstg(my_arch)
    generic map ( max   => 9,
                  width => 4 )
    port map ( clr  => clr,
               en   => en_2,
               clk  => clk,
               tick => tick_2,
               cnt  => cnt_2 );

  en_3 <= en_2 and tick_2;

--NOTE: 10 second counter
  ctrstg_3 : entity work.ctrstg(my_arch)
    generic map ( max   => 6,
                  width => 4 )
    port map ( clr  => clr,
               en   => en_3,
               clk  => clk,
               tick => tick_3,
               cnt  => cnt_3 );

  en_4 <= en_3 and tick_3;

--NOTE: Minute counter
  ctrstg_4 : entity work.ctrstg(my_arch)
    generic map ( max   => 4,
                  width => 4 )
    port map ( clr  => clr,
               en   => en_4,
               clk  => clk,
               tick => open,
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
               sseg => sseg_3 );

  hex_to_sseg_4 : entity work.hex_to_sseg(Behavioral)
    port map ( hex  => cnt_4,
               dp   => '1',                              --TODO: DON'T LIGHT UP?
               sseg => sseg_4 );

--ZERO BLANKER

  zero_blanker_4 : entity work.zero_blanker(my_arch)
    port map ( input  => sseg_4,
               output => blnk_4);

--DISPLAY MUX

  disp_mux : entity work.disp_mux(Behavioral)
    port map ( in0   => "11111111",
               in1   => "11111111",
               in2   => "11111111",
               in3   => "11111111",
               in4   => blnk_4,
               in5   => sseg_3,
               in6   => sseg_2,
               in7   => sseg_1,
               rst   => '0',
               clk   => clk,
               sseg  => sseg,
               anode => anode );

end my_arch;
