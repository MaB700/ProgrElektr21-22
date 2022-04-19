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
    signal count_h : integer range 0 to 2112 := 0;
    signal count_v : integer range 0 to 934 := 0;

    --Output     Output      Phase    Duty Cycle   Pk-to-Pk     Phase
    --Clock     Freq (MHz)  (degrees)    (%)     Jitter (ps)  Error (ps)
    --clk_out1   118.25000   0.000    50.0         198.842      305.719
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

    Hsync_timer : clk_wiz_0
    port map(
        clk_in1 => CLK,
        clk_out1 => s_hsync,
        -- Status and control signals                
        reset => s_reset,
        locked => s_locked
    );

    -- all values are from table C.1 for HD+ (1600x900)

    process (s_hsync) is
    begin
        if rising_edge(s_hsync) then
            count_h <= count_h + 1;
            vgaRed <= "0000";
            vgaGreen <= "0000";
            vgaBlue <= "0000";
            if count_h < 1600 then -- display time
                Hsync <= '1';
                vgaRed <= SW(3 downto 0);
                vgaGreen <= SW(7 downto 4);
                vgaBlue <= SW(11 downto 8);
            elsif count_h < 1696 then -- h-front porch
                Hsync <= '1';
            elsif count_h = 1696 then -- increase vertical counter
                Hsync <= '0';
                count_v <= count_v + 1;
            elsif count_h < 1856 then -- h-sync pulse
                Hsync <= '0';
            elsif count_h < 2111 then -- h-back porch -1
                Hsync <= '1';
            else -- last cycle of h-back porch, this is the 2112 h-cycle (count_h=2111)
                Hsync <= '1';
                count_h <= 0; -- reset horizontal count when going to next vertical line
                if count_v < 900 then
                    Vsync <= '1';
                elsif count_v < 903 then -- v-front porch
                    Vsync <= '1';
                    vgaRed <= "0000";
                    vgaGreen <= "0000";
                    vgaBlue <= "0000";
                elsif count_v < 908 then -- v-sync pulse
                    Vsync <= '0';
                elsif count_v < 933 then -- v-back porch -1
                    Vsync <= '1';
                    vgaRed <= "0000";
                    vgaGreen <= "0000";
                    vgaBlue <= "0000";
                else -- last cycle of v-back porch, this is the 934 v-cycle (count_v=933)
                    count_v <= 0;
                    vgaRed <= "0000";
                    vgaGreen <= "0000";
                    vgaBlue <= "0000";
                end if;
            end if;
        end if;
    end process;
end Behavioral;