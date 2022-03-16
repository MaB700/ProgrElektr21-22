library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_3_2 is
  Port (
    CLK : in std_logic;
    SW : in std_logic_vector (13 downto 0);
    C : out std_logic_vector (7 downto 0);
    A : out std_logic_vector (3 downto 0)     
  );
  
end project_3_2;

architecture Behavioral of project_3_2 is

begin
    display : entity work.display_wrapper
    port map (
        CLK => CLK,
        BINARY => SW,
        SEG => C(6 downto 0),
        DP => C(7),
        AN => A
    );

end Behavioral;
