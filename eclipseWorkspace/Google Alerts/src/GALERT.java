import java.io.FileReader;
import java.util.Arrays;
import java.util.List;

import org.nnh.service.*;
import org.nnh.bean.*;

import com.opencsv.CSVReader;

public class GALERT {

	public static void main(String[] args) throws Exception {
	    // Login to Google
		GAService service = new GAService("all-mail@akascia.com", "9nHBRrzC&vu5");
		service.doLogin();
		
		// Read in CSV to an Array called myEntries
	    CSVReader reader = new CSVReader(new FileReader("alerts_update.csv"));
        List <String[]> CompanyList = reader.readAll();
        
		String CommonQuery = " AND (Appointment OR Appointments OR Expands OR Expansion OR Executive OR EMEA OR APAC)";
		
		// Use try so that we can close 'reader'
		try{
			
			// Loop through the array columns to get the values in each row
			for (String[] Companies : CompanyList) {
				
				// Loop through the row to get the values in each column
			    for (String Company : Companies) {
			    	
			    	// Append the common query on to the company name
			    	String Query = "\\\"" + Company + "\\\"" + CommonQuery;
			    	
			    	// Create the Google Alert
			    	Alert alert = new Alert();
		    		alert.setHowMany(HowMany.ONLY_THE_BEST_RESULTS);
		    		alert.setHowOften(HowOften.ONCE_A_DAY);
		    		alert.setRegion(Region.Any_Region);
		    		alert.setLanguage(Language.English);
		    		alert.setSources(new String[]{Sources.NEWS,Sources.BLOGS,Sources.WEB});
		    		alert.setSearchQuery(Query);
		    		alert.setDeliveryTo(DeliveryTo.EMAIL);
		    		String id = service.createAlert(alert);
			    	
			        System.out.println(Query);
			    }
			}
		}
		finally {
	        reader.close();
		}	
	}
}
