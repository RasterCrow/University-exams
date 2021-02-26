package it.uniupo.labAlgo2;

import static org.junit.Assert.assertNotNull;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import it.uniupo.graphLib.DirectedGraph;
import it.uniupo.graphLib.GraphInterface;

class TestKosaraju {

	@Test
	public void testCreate() {
		DirectedGraph grafo = new DirectedGraph("4;0 2;1 2;1 0;3 1;3 0");
		Kosaraju sccTest = new Kosaraju(grafo); 
		assertNotNull(sccTest);
		}
	@Test
	public void testOrdineFineVisita() {
		DirectedGraph grafo = new DirectedGraph("5;1 4;4 3;3 1;1 2;4 0;0 2;2 0");
		Kosaraju sccTest = new Kosaraju(grafo); 
		//System.out.println(sccTest.postVisitList());
		assertNotNull(sccTest.postVisitList());
		}
	
	
	
	//un solo ciclo
	@Test
	public void TestScc1() {
		DirectedGraph grafo = new DirectedGraph("4;	0 1;1 2;2 3;3 0");
		Kosaraju sccTest = new Kosaraju(grafo); 
		int[] scc = sccTest.getSCC();

		System.out.println(scc[0]);
		System.out.println(scc[1]);
		System.out.println(scc[2]);
		System.out.println(scc[3]);
		assertEquals(scc[0],1);
	}
	@Test
	public void TescScc2() {

		System.out.println("scc2");
		DirectedGraph grafo = new DirectedGraph("8;0 2;0 4;2 4;2 5;4 2;4 7;6 5;3 1;1 2");
		Kosaraju sccTest = new Kosaraju(grafo); 
		int[] scc = sccTest.getSCC();

		assertEquals(scc[0],4);
		}

}
