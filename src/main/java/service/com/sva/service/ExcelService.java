package com.sva.service;
 
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;  
import java.lang.reflect.Field;  
import java.lang.reflect.InvocationTargetException;  
import java.lang.reflect.Method;  
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;  
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;  
import java.util.regex.Pattern;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;  
import org.apache.poi.hssf.usermodel.HSSFCellStyle;  
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;  
import org.apache.poi.hssf.usermodel.HSSFComment;  
import org.apache.poi.hssf.usermodel.HSSFFont;  
import org.apache.poi.hssf.usermodel.HSSFPatriarch;  
import org.apache.poi.hssf.usermodel.HSSFRichTextString;  
import org.apache.poi.hssf.usermodel.HSSFRow;  
import org.apache.poi.hssf.usermodel.HSSFSheet;  
import org.apache.poi.hssf.usermodel.HSSFWorkbook;  
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
  
/** 
 *  
 * @author leno 
 * @version v1.0 
 * @param <T> 
 *            应用泛型，代表任意一个符合javabean风格的类 
 *            注意这里为了简单起见，boolean型的属性xxx的get器方式为getXxx(),而不是isXxx() 
 *            byte[]表jpg格式的图片数据 
 */  
public class ExcelService<T>  
{   
    /**
     * @Fields log 输出日志
     */
    private static final Logger LOG = Logger.getLogger(ExcelService.class);
  
    /** 
     * 这是一个通用的方法，利用了JAVA的反射机制，可以将放置在JAVA集合中并且符号一定条件的数据以EXCEL 的形式输出到指定IO设备上 
     *  
     * @param title 表格标题名 
     * @param headers 表格属性列名数组 
     * @param dataset 需要显示的数据集合,集合中一定要放置符合javabean风格的类的对象。此方法支持的 
     *            javabean属性的数据类型有基本数据类型及String,Date,byte[](图片数据) 
     * @param out 与输出设备关联的流对象，可以将EXCEL文档导出到本地文件或者网络中 
     * @param pattern 如果有时间数据，设定输出格式。默认为"yyy-MM-dd" 
     */  
    @SuppressWarnings("unchecked")  
    public void exportExcel(String title, String[] headers,  
            Collection<T> dataset, OutputStream out, String pattern)  
    {  
        pattern="yyy-MM-dd HH:mm:ss";
        LOG.debug(pattern);
        // 声明一个工作薄  
        HSSFWorkbook workbook = new HSSFWorkbook();  
        // 生成一个表格  
        HSSFSheet sheet = workbook.createSheet(title);  
        // 设置表格默认列宽度为15个字节  
        sheet.setDefaultColumnWidth(18);  
        // 生成一个样式  
        HSSFCellStyle style = workbook.createCellStyle();  
        // 设置这些样式  
        style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);  
        style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);  
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);  
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);  
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);  
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
        // 生成一个字体  
        HSSFFont font = workbook.createFont();  
        font.setColor(HSSFColor.VIOLET.index);  
        font.setFontHeightInPoints((short) 12);  
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  
        // 把字体应用到当前的样式  
        style.setFont(font);  
        // 生成并设置另一个样式  
        HSSFCellStyle style2 = workbook.createCellStyle();  
        style2.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);  
        style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);  
        style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);  
        style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);  
        style2.setBorderRight(HSSFCellStyle.BORDER_THIN);  
        style2.setBorderTop(HSSFCellStyle.BORDER_THIN);  
        style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
        style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);  
        // 生成另一个字体  
        HSSFFont font2 = workbook.createFont();  
        font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);  
        // 把字体应用到当前的样式  
        style2.setFont(font2);
        // 默认样式
        HSSFFont font3 = workbook.createFont();  
        font3.setColor(HSSFColor.BLUE.index);  
  
        // 声明一个画图的顶级管理器  
        HSSFPatriarch patriarch = sheet.createDrawingPatriarch();  
        // 定义注释的大小和位置,详见文档  
        HSSFComment comment = patriarch.createComment(new HSSFClientAnchor(0,  
                0, 0, 0, (short) 4, 2, (short) 6, 5));  
        // 设置注释内容  
        comment.setString(new HSSFRichTextString("可以在POI中添加注释！"));  
        // 设置注释作者，当鼠标移动到单元格上是可以在状态栏中看到该内容.  
        comment.setAuthor("label");
  
        // 产生表格标题行  
        HSSFRow row = sheet.createRow(0);  
        for (int i = 0; i < headers.length; i++)  
        {  
            HSSFCell cell = row.createCell(i);  
            cell.setCellStyle(style);  
            HSSFRichTextString text = new HSSFRichTextString(headers[i]);  
            cell.setCellValue(text);  
        }
  
        // 遍历集合数据，产生数据行  
        Iterator<T> it = dataset.iterator();  
        int index = 0;  
        while (it.hasNext())  
        {  
            index++;  
            row = sheet.createRow(index);  
            T t = (T) it.next();  
            // 利用反射，根据javabean属性的先后顺序，动态调用getXxx()方法得到属性值  
            Field[] fields = t.getClass().getDeclaredFields();  
            for (int i = 0; i < fields.length; i++)  
            {
                HSSFCell cell = row.createCell(i);  
                cell.setCellStyle(style2);
                Field field = fields[i];
                String fieldName = field.getName();
                String getMethodName = "get"  
                        + fieldName.substring(0, 1).toUpperCase()
                        + fieldName.substring(1);
                try
                {  
                    @SuppressWarnings("rawtypes")
                    Class tCls = t.getClass();  
                    Method getMethod = tCls.getMethod(getMethodName, new Class[]{});  
                    Object value = getMethod.invoke(t, new Object[]{});
                    // 判断值的类型后进行强制类型转换  
                    String textValue = null;  
                    if (value instanceof Date)  
                    {  
                        LOG.debug(value.toString());
                        Date date = (Date) value;  
                        SimpleDateFormat sdf = new SimpleDateFormat(pattern);  
                        textValue = sdf.format(date);  
                    }
                    else if(value != null)
                    {  
                        // 其它数据类型都当作字符串简单处理  
                        textValue = value.toString();  
                    }
                    else{
                        textValue = ""; 
                    }
                    // 如果不是图片数据，就利用正则表达式判断textValue是否全部由数字组成  
                    if (textValue != null)  
                    {  
                        Pattern p = Pattern.compile("^//d+(//.//d+)?$");  
                        Matcher matcher = p.matcher(textValue);  
                        if (matcher.matches())  
                        {  
                            // 是数字当作double处理  
                            cell.setCellValue(Double.parseDouble(textValue));  
                        }  
                        else  
                        {  
                            HSSFRichTextString richString = new HSSFRichTextString(  
                                    textValue);  
                            richString.applyFont(font3);  
                            cell.setCellValue(richString);
                        }  
                    } 
                }  
                catch (SecurityException e)  
                {  
                    LOG.error(e);
                }  
                catch (NoSuchMethodException e)  
                {  
                    LOG.error(e);
                }  
                catch (IllegalArgumentException e)  
                {  
                    LOG.error(e);
                }  
                catch (IllegalAccessException e)  
                {  
                    LOG.error(e);
                }  
                catch (InvocationTargetException e)  
                {  
                    LOG.error(e);
                }  
                finally  
                {  
                    // 清理资源  
                }  
            }  
        }  
        try  
        {  
            workbook.write(out);
        }  
        catch (IOException e)  
        {  
            LOG.error(e);
        }
    }
    
    /**
     * 读取Excel数据内容
     * @param InputStream
     * @return Map 包含单元格数据内容的Map对象
     */
    public List<Map<String, String>> readExcelContent(InputStream is) {
        // 结果
        List<Map<String, String>> result = new ArrayList<Map<String, String>>();
        
        XSSFWorkbook wb;
        try {
            wb = new XSSFWorkbook(is);
            XSSFSheet sheet = wb.getSheetAt(0);
            // 得到总行数
            int rowNum = sheet.getLastRowNum();
            XSSFRow rowHeader = sheet.getRow(0);
            // 得到总列数
            int colNum = rowHeader.getPhysicalNumberOfCells();
            DataFormatter formatter = new DataFormatter();
            
            // 正文内容应该从第二行开始,第一行为表头的标题
            for (int i = 1; i <= rowNum; i++) {
                Map<String, String> content = new HashMap<String, String>();
                XSSFRow row = sheet.getRow(i);
                int j = 0;
                while (j < colNum) {
                    content.put(rowHeader.getCell(j).getStringCellValue(), formatter.formatCellValue(row.getCell(j)));
                    j++;
                }
                result.add(content);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }
}