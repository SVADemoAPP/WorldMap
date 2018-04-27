package com.sva.web.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;
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
    
    @RequestMapping(value="/getData", method= {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> getData(HttpServletRequest request, String filename){
        if(StringUtils.isEmpty(filename)){
            filename = "data.xlsx";
        }
        Map<String, Object> result = new HashMap<String, Object>();
        // 文件路径
        String filedir = request.getSession().getServletContext()
                .getRealPath("/WEB-INF/file");
        // 对读取Excel表格内容测试
        List<Map<String,String>> content = new ArrayList<Map<String,String>>();
        try{
            InputStream is = new FileInputStream(new File(filedir, filename));
            ExcelService<String> es = new ExcelService<String>();
            content = es.readExcelContent(is);
        }catch(Exception e){
            result.put("error", e);
            return result;
        }
        result.put("data", content);
        return result;
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
