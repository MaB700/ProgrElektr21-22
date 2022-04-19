library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_2_3_2 is
	port (
		I : in std_logic_vector (7 downto 0);
		C : out std_logic_vector (7 downto 0)
	);
end project_2_3_2;

architecture Behavioral of project_2_3_2 is
begin
	-- in 2 digits hex   out 8 bit SEG7
	with I select C <=
		b"0111_1111" when x"2E", -- .
		b"1100_0000" when x"30", -- 0
		b"1111_1001" when x"31",
		b"1010_0100" when x"32",
		b"1011_0000" when x"33",
		b"1001_1001" when x"34",
		b"1001_0010" when x"35",
		b"1000_0010" when x"36",
		b"1101_1000" when x"37",
		b"1000_0000" when x"38",
		b"1001_0000" when x"39", -- 9
		b"1000_1000" when x"41" | x"61", -- A
		b"1000_0011" when x"42" | x"62",
		b"1010_0111" when x"43" | x"63",
		b"1010_0001" when x"44" | x"64",
		b"1000_0110" when x"45" | x"65",
		b"1000_1110" when x"46" | x"66", -- F
		b"1100_0010" when x"47" | x"67", -- G
		b"1000_1011" when x"48" | x"68", -- H
		b"1111_1011" when x"49" | x"69", -- I
		b"1110_0001" when x"4A" | x"6A", -- J
		b"1000_1010" when x"4B" | x"6B", -- K
		b"1100_0111" when x"4C" | x"6C", -- L
		b"1100_1000" when x"4D" | x"6D", -- M
		b"1010_1011" when x"4E" | x"6E", -- N
		b"1010_0011" when x"4F" | x"6F", -- O
		b"1000_1100" when x"50" | x"70", -- P
		b"1001_1000" when x"51" | x"71", -- Q
		b"1010_1111" when x"52" | x"72", -- R
		b"1001_0011" when x"53" | x"73", -- S
		b"1000_0111" when x"54" | x"74", -- T
		b"1110_0011" when x"55" | x"75", -- U
		b"1100_0001" when x"56" | x"76", -- V
		b"1000_0001" when x"57" | x"77", -- W
		b"1000_1001" when x"58" | x"78", -- X
		b"1001_0001" when x"59" | x"79", -- Y
		b"1110_0100" when x"5A" | x"7A", -- Z
		b"1111_1111" when others; -- empty else case
end Behavioral;