package lu.its4u.pocnewrelicoc.jolokia;

import javax.management.MalformedObjectNameException;

import org.jolokia.client.J4pClient;
import org.jolokia.client.exception.J4pException;
import org.jolokia.client.request.J4pReadRequest;
import org.jolokia.client.request.J4pReadResponse;

public class JolokiaClient {
	public static void main(String[] args) {
		J4pClient client = new J4pClient("http://localhost:8778/jolokia");
		J4pReadRequest request;
		try {
			request = new J4pReadRequest("java.lang:type=Memory", "HeapMemoryUsage");
			request.setPath("used");
			while(true) {
				J4pReadResponse response = client.execute(request);
				System.out.println("Memory used: " + response.getValue());
				Thread.sleep(10000l);
			}
		} catch (MalformedObjectNameException e) {
			e.printStackTrace();
		} catch (J4pException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
