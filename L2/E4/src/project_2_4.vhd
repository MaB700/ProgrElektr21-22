library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_2_4 is
	port (
		I : in std_logic_vector (7 downto 0);
		O : out std_logic_vector (2 downto 0);
		VALID : out std_logic -- LED <V19>
	);
end project_2_4;

architecture Behavioral of project_2_4 is
begin
	O <="111" when I(7) = '1' else -- use the priority when chaining 'when else' statements
		"110" when I(6) = '1' else -- therefore check on which position the first '1' is
		"101" when I(5) = '1' else -- and return the hardcoded result
		"100" when I(4) = '1' else
		"011" when I(3) = '1' else
		"010" when I(2) = '1' else
		"001" when I(1) = '1' else
		"000";

	with I select VALID <= -- LED lights up if input is invalid
		'1' when "0000000",
		'0' when others;
end Behavioral;