library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_9_3 is
  Port ( 
  CLK : in std_logic;
  vgaRed : out std_logic_vector(3 downto 0);
  vgaGreen : out std_logic_vector(3 downto 0);
  vgaBlue : out std_logic_vector(3 downto 0) 
  );
end project_9_3;

architecture Behavioral of project_9_3 is
signal REN, WEN : std_logic := '0';
signal WADD : std_logic_vector(19 downto 0);
signal RADD : std_logic_vector(19 downto 0);
signal DIN : std_logic_vector(11 downto 0);
signal DOUT : std_logic_vector(11 downto 0);
--signal hsync : 
begin

 video_ram : entity work.ram_init
 port map (
    CLK => CLK,
    WEN => WEN,
    REN => REN,
    WADD => WADD,
    RADD => RADD,
    DIN => DIN,
    DOUT => DOUT
 );

display_output : entity work.project_9_1
port map (
        CLK => CLK,
        SW => DOUT,
        Hsync => ,
        Vsync =>;
        vgaRed >: out std_logic_vector(3 downto 0);
        vgaGreen : out std_logic_vector(3 downto 0);
        vgaBlue : out std_logic_vector(3 downto 0) 
);

end Behavioral;
