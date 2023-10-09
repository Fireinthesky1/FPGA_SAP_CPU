-- VHDL 8 bit processor project
-- Three Bit ALU Test Bench
-- James Hicks Oct 9 2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity three_bit_ALU_tb is
end three_bit_ALU_tb;

architecture tb_arch of three_bit_ALU_tb is

    signal num1, num2 : std_logic_vector(2 downto 0);
    signal control    : std_logic_vector(3 downto 0);
    signal result     : std_logic_vector(5 downto 0);

begin

    DUT : entity work.three_bit_ALU(my_arch)
        port map (
                    num1 => num1,
                    num2 => num2,
                    s_u => control(3),
                    add => control(2),
                    subtract => control(1),
                    multiply => control(0),
                    result => result
                 );

    process begin
        for I in 0 to 15 loop
            num1 <= "111";
            num2 <= "001";
            control <= std_logic_vector(to_unsigned(I,4));
            wait for 1 ns;
        end loop;

        assert false report "end of test";
        wait;

    end process;

end tb_arch;