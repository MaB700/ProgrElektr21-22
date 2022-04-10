library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity project_2_5 is
    port (
        SW : in std_logic_vector (11 downto 0);
        C : out std_logic_vector (7 downto 0);
        A : out std_logic_vector (3 downto 0);
        LED : out std_logic
    );
end project_2_5;

architecture Behavioral of project_2_5 is
    signal wire_1, wire_2, wire_3, wire_4 : std_logic_vector (7 downto 0); -- wires connecting to C based on mode
    signal wire_4_2 : std_logic_vector (2 downto 0); -- highest active switch output in binary, project_2_4
    signal wire_led : std_logic; -- used for VALID in project_2_4
begin
    -- "00" manage 7+1 segments
    project_2_1 : entity work.project_2_1
        port map(
            SW => SW(7 downto 0),
            C => wire_1,
            A => open
        );

    -- "01" display hex digit
    project_2_2 : entity work.project_2_2
        port map(
            I => SW(7 downto 0),
            C => wire_2
        );
    
    -- "10" 2 hex numbers to ASCII character
    project_2_3 : entity work.project_2_3_1
        port map(
            SW => SW(7 downto 0),
            C => wire_3,
            A => A
        );

    -- "11" highest switch index in binary
    project_2_4 : entity work.project_2_4
        port map(
            I => SW(7 downto 0),
            VALID => wire_led,
            O => wire_4_2
        );
    
    -- "11" transform binary in SEG7 using hex digit display
    project_2_2_4 : entity work.project_2_2
        port map(
            I(2 downto 0) => wire_4_2, -- only use lowest 3 bits as to represent numbers [0, 7]
            I(7 downto 3) => (others => '0'), -- set rest of the bits to '0' all the time
            C => wire_4
        );

    -- SW(9) & SW(8) as mode input
    -- all methods are calculated permanently, only the wire connected to C changes based on SW(9) & SW(8) 
    with SW(9 downto 8) select C <=
        wire_1 when "00",
        wire_2 when "01",
        wire_3 when "10",
        wire_4 when "11";

    -- select which of the 4 segments to use
    A <= "1110" when SW(11 downto 10) = b"00" else
         "1101" when SW(11 downto 10) = b"01" else
         "1011" when SW(11 downto 10) = b"10" else
         "0111" when SW(11 downto 10) = b"11";
    
    -- specify what the LED does in case "01" "11" , otherwise LED is off
    LED <= '1' when SW(9 downto 8) = b"01" and (SW(4) = '1' or SW(5) = '1' or SW(6) = '1' or SW(7) = '1') else -- number too large
           '1' when SW(9 downto 8) = b"11" and wire_led = '1' else
           '0';
end Behavioral;