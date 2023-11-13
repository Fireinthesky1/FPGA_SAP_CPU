-- JAMES HICKS 11/12/2023
-- TODO::TEST THIS

library ieee;
use ieee.std_logic_1164.all;

entity threebit_2seg is
  port ( clk : in  std_logic;
         btn : in  std_logic;
         rst : in  std_logic;
         cnt : out std_logic_vector(2 downto 0);
         );
end threebit_2seg;

architecture two_seg of threebit_2seg is

  signal r_pres, r_next : unsigned;
  signal btn_db : std_logic;

begin

  debouncer : entity work.debouncer(scheme1_arch)
    port map ( reset => rst,
               clk   => clk,
               sw    => btn,
               db    => btn_db
             );

--TODO::do we use btn_db as a sensitivity here?

  two_seg : process (btn_db, rst)
  begin
    if (rst = '1') then
      cnt <= (others => '0')
    elsif (rising_edge(btn_db)) then
      if (en = '1') then
        r_pres <= r_next;
      end if;
    end if;
  end process;

  r_next <= r_pres + 1;

  cnt <= std_logic_vector(r_pres);

end two_seg;
