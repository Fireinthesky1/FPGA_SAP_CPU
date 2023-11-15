library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity threebitcounter is
  port ( clk : in  std_logic;
         btn : in  std_logic;
         rst : in  std_logic;
         cnt : out std_logic_vector(2 downto 0)
       );
end threebitcounter;

architecture my_arch of threebitcounter is

signal q0_int, q1_int, q2_int, btn_db : std_logic;

begin

  debouncer : entity work.debouncer(scheme1_arch)
    port map ( reset => rst,
               clk   => clk,
               sw    => btn,
               db    => btn_db);

  q2_int <= q0_int and q1_int;

  ff_1 : entity work.t_ff(two_seg_arch)
    port map ( t   => '1',
               en  => '1',
               rst => rst,
               clk => btn_db,
               q   => q0_int
             );

  ff_2 : entity work.t_ff(two_seg_arch)
    port map ( t   => q0_int,
               en  => '1',
               rst => rst,
               clk => btn_db,
               q   => q1_int);

  ff_3 : entity work.t_ff(two_seg_arch)
    port map (t    => q2_int,
              en   => '1',
              rst  => rst,
              clk  => btn_db,
              q    => cnt(2)
              );

  cnt(1) <= q1_int;
  cnt(0) <= q0_int;

end my_arch;


architecture two_seg of threebitcounter is

  signal r_pres, r_next : unsigned(2 downto 0) := "000";
  signal btn_db : std_logic;

begin

  debouncer : entity work.debouncer(scheme1_arch)
    port map ( reset => rst,
               clk   => clk,
               sw    => btn,
               db    => btn_db
             );

  two_seg : process (btn_db, rst)
  begin
    if (rst = '1') then
      r_pres <= (others => '0');
    elsif (btn_db'event and btn_db = '1') then
      r_pres <= r_next;
    end if;
  end process;

  r_next <= r_pres + 1;

  cnt <= std_logic_vector(r_pres);

end two_seg;

