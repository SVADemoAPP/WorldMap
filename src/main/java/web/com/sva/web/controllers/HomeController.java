package com.sva.web.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.sva.model.LocationModel;
import com.sva.model.MapsModel;
import com.sva.service.ExcelService;
import com.sva.web.models.HeatmapModel;

/**
 * <p>Title:HomeController</p>
 * <p>Description:页面菜单跳转controller</p>
 * <p>Company: ICS</p>
 * @author label
 * @date 2016年6月30日 下午2:59:26
 */
@Controller
@RequestMapping(value = "")
public class HomeController
{
    /** 
     * @Fields servic : 热力图服务 
     */ 
    private ExcelService service;
    
    private static final Logger LOG = Logger.getLogger(HomeController.class);
    
    /** 
     * @Title: showHeatmap 
     * @Description: 显示热力图页面 
     * @param requestModel
     * @param model
     * @return 
     */
    @RequestMapping(value="/home", method={RequestMethod.GET})
    public String showHeatmap(HeatmapModel requestModel, Model model){
        
        return "web/worldMap";
    }

    /** 
     * @Title: handleException 
     * @Description: 未知异常处理
     * @param ex
     * @return 
     */
    @ExceptionHandler(RuntimeException.class)
    public String handleException(RuntimeException ex, Model model)
    {
        String info = "未知错误: " + ex.getMessage();
        model.addAttribute("info", info);
        return "error";
    }
}
