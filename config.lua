if string.sub(system.getInfo("model"),1,4) == "iPad" then
    -- iPad 2 and iPad retina
    application = 
    {
        content =
        {
            width = 720,
            height = 1280,
            scale = "zoomStretch",
            xAlign = "center",
            yAlign = "center",
            imageSuffix = 
            {
                --["@2x"] = 1.6,
                --["@4x"] = 3.0,
            },
        },
        
        notification = 
        {   
        --     google =
        --    {
        --    projectNumber = "44912882295"
        --    },
            iphone = {
                types = {
                    "badge", "sound", "alert", "custom"
                }
            }
        }
    }

elseif string.sub(system.getInfo("model"),1,2) == "iP" and display.pixelHeight > 960 then
    -- iPhone 5 & 5S
    application = 
    {
        content =
        {
            width = 720,
            height = 1280,
            scale = "letterbox",
            xAlign = "center",
            yAlign = "center",
            imageSuffix = 
            {
                --["@2x"] = 0.889,
                --["@4x"] = 3.0,
            },
        },
        

        notification = 
        {   
         --    google =
        --{
        --    projectNumber = "44912882295"
        --},
            iphone = {
                types = {
                    "badge", "sound", "alert"
                }
            }
        }
    }

elseif string.sub(system.getInfo("model"),1,2) == "iP" then
    --iPhone 4, 4S, iPod older generations
    application = 
    {
        content =
        {
            width = 640,
            height = 960,
            scale = "letterbox",
            xAlign = "center",
            yAlign = "center",
            imageSuffix = 
            {
                --["@2x"] = 2.0,
                --["@4x"] = 3.0,
            },
        },

        

        notification = 
        {   
        --     google =
        --{
        --    projectNumber = "44912882295"
        --},
            iphone = {
                types = {
                    "badge", "sound", "alert"
                }
            }
        }
    }
elseif (display.pixelHeight / display.pixelWidth > 1.75 and  display.pixelHeight / display.pixelWidth < 1.78 ) then
    -- Android higher resolution devices Samsung S3, S4, S5, Note 2, Note 3, etc
    application = 
    {
        content =
        {
            width = 720,
            height = 1280,
            scale = "letterbox",
            xAlign = "center",
            yAlign = "center",
            imageSuffix = 
            {
                --["@2x"] = 1.5,
                --["@4x"] = 3.0,
            },
        },

        --[[license =
        {
            google =
            {
                key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAkKa9q7X9pEV0Hd7yzX1OH5zCG4w1PeuuijN1ohQb1+VFCuAfpkHvPNENRNec4g3Rk4erA14V2lPrZNeKHaPoZVr+BIn7LFlhSb0y8cGDl12XzB/yY/A63rJHjrx5Ov6gIUGeUzdjK3PzMklx4nBz/1TdtImd4S5rfUWfJDGS0Bnfq2/DVR8SYQJDfIUH3KspPqztCsIQep076AcxbJRXe3EUgeBun7tLC7bQg+BmLVmYPkqDmIHAJgc/EWdJfnE6dOEjC5/xfHr8PSk8pn4pxz7cdwpk3TYb1Rv7rlcUT2Vto/ZZiLrSk+5/M8cIyb61OcoJb8ffrTpcNGxJN6618wIDAQAB"
            },
        },]]--
        notification = 
        {   
        --     google =
        --{
        --    projectNumber = "44912882295"
        --},
            iphone = {
                types = {
                    "badge", "sound", "alert"
                }
            }
        }

    }
elseif (display.pixelHeight / display.pixelWidth == 1.6) then
    -- Android devices like Samsung Tab
    application = 
    {
        content =
        {
            width = 800,
            height = 1280,
            scale = "letterbox",
            xAlign = "center",
            yAlign = "center",
            imageSuffix = 
            {
                --["@2x"] = 2.0,
                
                
            },
        },

        notification = 
        {   
        --     google =
        --{
        --    projectNumber = "44912882295"
        --},
            iphone = {
                types = {
                    "badge", "sound", "alert"
                }
            }
        }

        
    }
else
    -- android lower resolution devices
    application = 
    {
        content =
        {
            width = 720,
            height = 1280,
            scale = "zoomStretch",
            xAlign = "center",
            yAlign = "center",
            imageSuffix = 
            {
                --["@2x"] = 2.0,
                --["@4x"] = 3.0,
            },
        },

        
        notification = 
        {   
        --     google =
        --{
        --    projectNumber = "44912882295"
        --},
            iphone = {
                types = {
                    "badge", "sound", "alert"
                }
            }
        }
    }
end
