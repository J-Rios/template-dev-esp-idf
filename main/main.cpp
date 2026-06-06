/**
 * @file    main.cpp
 * @author  XXXX XXXXX
 * @date    YYYY.MM.DD
 * @version 1.0.0
 * @brief   Project Main application file.
 */

/*****************************************************************************/

/* Libraries */

// Standard Libraries
#include <stdio.h>
#include <inttypes.h>

// ESP-IDF SDK Config Libraries
#include "sdkconfig.h"

// ESP-IDF FreeRTOS Libraries
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

// ESP-IDF System Libraries
#include "esp_chip_info.h"
#include "esp_flash.h"
#include "esp_system.h"

/*****************************************************************************/

/* Main Function */

extern "C" { void app_main(void); }

void app_main(void)
{
    printf("\n");
    printf("Application Start\n");
    printf("\n");

    // Get ESP chip information
    esp_chip_info_t chip_info;
    esp_chip_info(&chip_info);
    uint16_t chip_hw_version_major = (chip_info.revision / 100U);
    uint16_t chip_hw_version_minor = (chip_info.revision % 100U);
    uint32_t flash_size = 0U;
    if(esp_flash_get_size(NULL, &flash_size) != ESP_OK)
    {
        printf("Fail to get Flash size\n");
        return;
    }

    /* Print chip information */
    printf("ESP Chip Information:\n");
    printf("---------------------\n");
    printf("  - Chip: %s\n", CONFIG_IDF_TARGET);
    printf("  - HW Version: v%d.%d\n",
        static_cast<int>(chip_hw_version_major),
        static_cast<int>(chip_hw_version_minor));
    printf("  - Cores: %d\n", chip_info.cores);
    printf("  - WiFi: %s\n",
        (chip_info.features & CHIP_FEATURE_WIFI_BGN) ? "YES" : "NO");
    printf("  - BT: %s\n",
        (chip_info.features & CHIP_FEATURE_BT) ? "YES" : "NO");
    printf("  - BLE: %s\n",
        (chip_info.features & CHIP_FEATURE_BLE) ? "YES" : "NO");
    printf("  - 802.15.4 (Zigbee/Thread): %s\n",
        (chip_info.features & CHIP_FEATURE_IEEE802154) ? "YES" : "NO");
    printf("  - Flash Memory: %" PRIu32 " MB (%s)\n",
        flash_size / static_cast<uint32_t>(1024U * 1024U),
        (chip_info.features & CHIP_FEATURE_EMB_FLASH) ? "Embedded" : "External");
    printf("\n");

    // Automatic Restart
    for (int i = 60; i >= 0; i--)
    {
        printf("Restarting in %d seconds...\n", i);
        vTaskDelay(1000U / portTICK_PERIOD_MS);
    }
    printf("Restarting now.\n");
    fflush(stdout);
    esp_restart();
}

/*****************************************************************************/
