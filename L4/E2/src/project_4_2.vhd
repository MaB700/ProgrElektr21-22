library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_4_2 is
    Port ( 
        CLK : in std_logic;
        SW : in std_logic_vector(13 downto 0);
        C : out std_logic_vector(7 downto 0);
        A : out std_logic_vector(3 downto 0)
    );
end project_4_2;

architecture Behavioral of project_4_2 is
signal wire_bin_dec : std_logic_vector(15 downto 0) := (others => '0');
signal valid : std_logic:='0';
signal error : std_logic_vector(15 downto 0);
signal dist_in : std_logic_vector(15 downto 0) := (others => '0');
signal A_out : std_logic_vector(3 downto 0);
begin
    error(15 downto 12) <= x"E";
    error(11 downto 8) <= x"E";
    error(7 downto 4) <= x"E";
    error(3 downto 0) <= x"E";
    
    dist_in <= wire_bin_dec when valid='1' else error; 
    A <= A_out when valid='1' else "1110";
    Display : entity work.project_4_1
    port map (
        CLK => CLK,
        SW => dist_in,
        C => C, 
        A => A_out
    );
    
    BCD : entity work.BCD
    port map (
        BIN => SW,
        BCD => wire_bin_dec,
        VALID => valid         
    );
    
end Behavioral;