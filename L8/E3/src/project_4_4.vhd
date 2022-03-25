library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_4_4 is
    Port ( 
        CLK : in std_logic; 
        I : in std_logic_vector(31 downto 0);
        MODE : in std_logic_vector(1 downto 0);
        C : out std_logic_vector(7 downto 0);
        A : out std_logic_vector(3 downto 0)
    );
end project_4_4;

architecture Behavioral of project_4_4 is
signal wire_00C,wire_01C,wire_10C,wire_11C: std_logic_vector(7 downto 0);
signal wire_00A,wire_01A,wire_10A,wire_11A : std_logic_vector(3 downto 0);
begin
    C <= wire_00C when MODE = "00" else
         wire_01C when MODE = "01" else
         wire_10C when MODE = "10" else
         wire_11C ;
    A <= wire_00A when MODE = "00" else
         wire_01A when MODE = "01" else
         wire_10A when MODE = "10" else
         wire_11A ;
    

    mode_00 : entity work.project_4_4_0
    port map (
        CLK => CLK,
        INP => I,
        C => wire_00C,  
        A => wire_00A
    );
    
    mode_01 : entity work.project_4_4_1
    port map (
        CLK => CLK,
        INP => I,
        C => wire_01C,  
        A => wire_01A
    );
    
    mode_10 : entity work.project_4_4_2
    port map (
        CLK => CLK,
        INP => I(13 downto 0),
        C => wire_10C,  
        A => wire_10A
    );
    
    mode_11 : entity work.project_4_4_3
    port map (
        CLK => CLK,
        SW => I,
        C => wire_11C,  
        A => wire_11A
    );

end Behavioral;
