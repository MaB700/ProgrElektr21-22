library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity project_9_3 is
    port (
        CLK : in std_logic;
        Hsync : out std_logic;
        Vsync : out std_logic;
        vgaRed : out std_logic_vector(3 downto 0);
        vgaGreen : out std_logic_vector(3 downto 0);
        vgaBlue : out std_logic_vector(3 downto 0)
    );
end project_9_3;

architecture Behavioral of project_9_3 is
    signal s_reset, s_locked : std_logic := '0';
    signal s_hsync : std_logic;
    signal count_h : integer range 0 to 2112 := 0;
    signal count_v : integer range 0 to 934 := 0;
    signal s_bw : std_logic := '0';
    signal REN, WEN : std_logic := '0';
    signal WADD : std_logic_vector(9 downto 0) := (others => '0');
    signal RADD : std_logic_vector(9 downto 0) := (others => '0');
    signal DIN : std_logic_vector(1599 downto 0) := (others => '0');
    signal DOUT : std_logic_vector(1599 downto 0) := (others => '0');

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

    video_ram : entity work.ram_init
        port map(
            CLK => s_hsync,
            WEN => WEN,
            REN => REN,
            WADD => WADD,
            RADD => RADD,
            DIN => DIN,
            DOUT => DOUT
        );

    REN <= '1'; -- read all the time and only change address based on count_v
    RADD <= std_logic_vector(to_unsigned(count_v, 10));    
    -- 1599 - count_h, to revert the horizontal flip
    s_bw <= not DOUT(1599 - count_h) when 1599 - count_h >= 0 else -- black or white value for each h-pixel
            '0';

    process (s_hsync) is
    begin
        if rising_edge(s_hsync) then
            count_h <= count_h + 1;
            vgaRed <= "0000";
            vgaGreen <= "0000";
            vgaBlue <= "0000";
            if count_h < 1600 then
                Hsync <= '1';
                vgaRed <= s_bw & s_bw & s_bw & s_bw; -- turn black and white values 0,1 into rgb values
                vgaGreen <= s_bw & s_bw & s_bw & s_bw; -- "0000" , "1111"
                vgaBlue <= s_bw & s_bw & s_bw & s_bw;
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