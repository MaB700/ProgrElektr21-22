library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_2_1 is
	port (
		SW : in std_logic_vector (7 downto 0);
		C : out std_logic_vector (7 downto 0);
		A : out std_logic_vector (3 downto 0)
	);
end project_2_1;

architecture Behavioral of project_2_1 is
begin
	C <= SW; -- directly control the 7+1 segments with the 8 switches
	A <= "1110"; -- only run the first segment of the display
end Behavioral;