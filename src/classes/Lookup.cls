/**
 * @author		: Jitendra Zaa 
 * @date		: 2017-07-04
 * @description : Controller for Lookup Lightning Component. Peter Ogilvie (code@ogilvie.us.com)
 *                stylistic modifications for use in NPSP outbound funds extension 
 */
public class Lookup {

    /**
     * @return               : JSON of list of ResultWrapper to Lex Components
     * @param objectName     : Name of SObject
     * @param fld_API_Text   : API name of field to display to user while searching
     * @param fld_API_Val    : API name of field to be returned by Lookup COmponent
     * @param lim            : Total number of record to be returned
     * @param fld_API_Search : API name of field to be searched
     * @param searchText     : text to be searched
     */
    @AuraEnabled public static String searchDB(
        String objectName, 
        String fld_API_Text, 
        String fld_API_Val, 
        Integer lim,
        String fld_API_Search,
        String searchText)
    {
        searchText = '\'%' + String.escapeSingleQuotes(searchText.trim()) + '%\'';
        
        final String 
            selectStr =  'SELECT '+ fld_API_Text + ' ,' + fld_API_Val,
            fromStr   = ' FROM '  + objectName, 
            whereStr  = ' WHERE ' + fld_API_Search + ' LIKE ' + searchText, 
            limitStr  = ' LIMIT ' + lim,
            query     = selectStr + fromStr + whereStr + limitStr;  
        
        List<sObject> sobjList = Database.query(query);
        List<ResultWrapper> returnList = new List<ResultWrapper>();
        
        for(SObject s : sobjList) {
            returnList.add(new ResultWrapper(
                objectName,
                String.valueOf(s.get(fld_API_Text)),
                String.valueOf(s.get(fld_API_Val))
            ));
        } 
        return JSON.serialize(returnList) ;
    }
    
    /* Helper class defines element of a list of return values
    */ 
    class ResultWrapper {

        String objName;
        String text;
        String val;

        ResultWrapper(String o, String t, String v) {
            objName = o;
            text = t;
            val = v;
        }
    }
}