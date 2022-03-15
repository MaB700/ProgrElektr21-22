library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity project_2_5 is
  Port ( 
        SW : in std_logic_vector (11 downto 0);
        C  : out std_logic_vector (7 downto 0);
        A  : out std_logic_vector (3 downto 0);
        LED: out std_logic
        );
end project_2_5;

architecture Behavioral of project_2_5 is
    signal wire_4_2 : std_logic_vector (2 downto 0);
    signal wire_1, wire_2, wire_3, wire_4 : std_logic_vector (7 downto 0);
    signal wire_led : std_logic;
begin

    -- SW(9) & SW(8) as mode input
    -- SW(9 downto 8) == "00"
        -- output manage segments
    
    -- "00" manage segments +
    project_2_1 : entity work.project_2_1
        port map (
            SW => SW(7 downto 0),
            C => wire_1,
            A => OPEN
        );
    
    -- "01" display hex digit +
    project_2_2 : entity work.project_2_2
        port map (
            I => SW(7 downto 0),
            C => wire_2
        );
        
        
    -- "10" ASCII character
    project_2_3 : entity work.project_2_3_1
        port map (
            SW => SW(7 downto 0),
            C => wire_3,
            A => A
        );
    
    -- "11" highest switch index in hex +
    project_2_4 : entity work.project_2_4
        port map (
            I => SW(7 downto 0),
            VALID => wire_led,
            O => wire_4_2
        );
    
    project_2_2_4 : entity work.project_2_2
        port map (
            I(7 downto 3) => (others=>'0'),
            I(2 downto 0) => wire_4_2,
            C => wire_4
        );
            
    with SW(9 downto 8) select C <=
        wire_1 when "00",
        wire_2 when "01",
        wire_3 when "10",
        wire_4 when "11";
        
    A <= "1110";
        
    LED <= '1' when SW(9 downto 8) = b"01" and (SW(4)='1' or SW(5)='1' or SW(6)='1' or SW(7)='1') else 
           '1' when SW(9 downto 8) = b"11" and wire_led = '1' else '0';
    
end Behavioral;