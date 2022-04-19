library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_9_1 is
    port (
        CLK : in std_logic;
        SW : in std_logic_vector(11 downto 0);
        Hsync : out std_logic;
        Vsync : out std_logic;
        vgaRed : out std_logic_vector(3 downto 0);
        vgaGreen : out std_logic_vector(3 downto 0);
        vgaBlue : out std_logic_vector(3 downto 0)
    );
end project_9_1;

architecture Behavioral of project_9_1 is
    signal s_reset, s_locked : std_logic := '0';
    signal s_hsync : std_logic;
    signal r2_circle : integer range 0 to 3e8 := 0;
    signal count_h : integer range 0 to 2112 := 0;

    signal count_v : integer range 0 to 934 := 0;
    signal s_red, s_green, s_blue : std_logic_vector(3 downto 0) := (others => '0');
    component clk_wiz_0
        port (
            clk_in1 : in std_logic;
            clk_out1 : out std_logic;
            -- Status and control signals
            reset : in std_logic;
            locked : out std_logic
        );
    end component;
begin
    -- circle radius^2 based on count_h & count_v
    -- circle is centered at (800, 450) 
    r2_circle <= (((count_h - 800) ** 2) + ((count_v - 450) ** 2));

    Hsync_timer : clk_wiz_0
    port map(
        clk_in1 => CLK,
        clk_out1 => s_hsync,
        -- Status and control signals                
        reset => s_reset,
        locked => s_locked
    );

    process (s_hsync) is
    begin
        if rising_edge(s_hsync) then
            count_h <= count_h + 1;
            vgaRed <= "0000";
            vgaGreen <= "0000";
            vgaBlue <= "0000";
            if count_h < 1600 then
                Hsync <= '1';
                -- usage of if, elsif priority -> smaller circles have proirity in being drawn
                if r2_circle < (1 * 50) * (1 * 50) then 
                    vgaRed <= not s_red; -- invert colors based on circle radius^2
                    vgaGreen <= not s_green;
                    vgaBlue <= not s_blue;
                elsif r2_circle < (2 * 50) * (2 * 50) then
                    vgaRed <= s_red;
                    vgaGreen <= s_green;
                    vgaBlue <= s_blue;
                elsif r2_circle < (3 * 50) * (3 * 50) then
                    vgaRed <= not s_red;
                    vgaGreen <= not s_green;
                    vgaBlue <= not s_blue;
                elsif r2_circle < (4 * 50) * (4 * 50) then
                    vgaRed <= s_red;
                    vgaGreen <= s_green;
                    vgaBlue <= s_blue;
                elsif r2_circle < (5 * 50) * (5 * 50) then
                    vgaRed <= not s_red;
                    vgaGreen <= not s_green;
                    vgaBlue <= not s_blue;
                elsif r2_circle < (6 * 50) * (6 * 50) then
                    vgaRed <= s_red;
                    vgaGreen <= s_green;
                    vgaBlue <= s_blue;
                elsif r2_circle < (7 * 50) * (7 * 50) then
                    vgaRed <= not s_red;
                    vgaGreen <= not s_green;
                    vgaBlue <= not s_blue;
                else
                    vgaRed <= s_red;
                    vgaGreen <= s_green;
                    vgaBlue <= s_blue;
                end if;

            elsif count_h < 1696 then
                Hsync <= '1';
            elsif count_h = 1696 then
                Hsync <= '0';
                count_v <= count_v + 1;
            elsif count_h < 1856 then
                Hsync <= '0';
            elsif count_h < 2111 then
                Hsync <= '1';
            else
                Hsync <= '1';
                count_h <= 0;
                if count_v < 900 then
                    Vsync <= '1';
                elsif count_v < 903 then
                    Vsync <= '1';
                    vgaRed <= "0000";
                    vgaGreen <= "0000";
                    vgaBlue <= "0000";
                elsif count_v < 908 then
                    Vsync <= '0';
                    s_red <= SW(3 downto 0); -- reset or update colors at the end of one full picture 
                    s_green <= SW(7 downto 4); -- color is based on switches
                    s_blue <= SW(11 downto 8);
                elsif count_v < 933 then
                    Vsync <= '1';
                    vgaRed <= "0000";
                    vgaGreen <= "0000";
                    vgaBlue <= "0000";
                else
                    count_v <= 0;
                    vgaRed <= "0000";
                    vgaGreen <= "0000";
                    vgaBlue <= "0000";
                end if;
            end if;
        end if;
    end process;
end Behavioral;