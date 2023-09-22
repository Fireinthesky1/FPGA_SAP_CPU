-- VHDL 8 bit processor Project
-- GHDL Hello World Test
-- James Hicks Sept 22 2023

-- Hello World Program --
use std.textio.all; -- imports the standard textio package

-- Defines a design entity, without any ports.
entity hello_world is
end hello_world;

architecture behavior of hello_world is
begin
    process
        variable l : line;
    begin
        write (l, String'("Hello World"));
        writeline (output, l);
        wait;
    end process;
end behavior;